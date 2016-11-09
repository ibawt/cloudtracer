module Cloudtracer
  module Notifications
    extend self

    TOPICS = %w(
      write_fragment.action_controller
      read_fragment.action_controller
      expire_fragment.action_controller
      exist_fragment?.action_controller
      write_page.action_controller
      expire_page.action_controller
      start_processing.action_controller
      process_action.action_controller
      send_file.action_controller
      send_data.action_controller
      redirect_to.action_controller
      halted_callback.action_controller
      render_template.action_view
      render_partial.action_view
      sql.active_record
      instantiation.active_record
      receive.action_mailer
      deliver.action_mailer
      cache_read.active_support
      cache_generate.active_support
      cache_fetch_hit.active_support
      cache_write.active_support
      cache_delete.active_support
      enqueue_at.active_job
      enqueue.active_job
      perform_start.active_job
      perform.active_job
    ).freeze

    def register!
      (TOPICS - Cloudtracer.config.blacklist_topics).each do |topic|
        subscribe topic
      end
    end

    def update(name, started, finished, data)
      return unless Cloudtracer.current_context
      span = Google::Apis::CloudtraceV1::TraceSpan.new(
        name: name,
        start_time: started,
        end_time: finished,
        labels: clean_labels(data)
      )

      return unless process_span(name, span)
      Cloudtracer.current_context.update(span)
    end

    def process_span(name, span)
      m = to_method(name)
      return send(m, span) if respond_to?(m)
      span
    end

    def start_processing_action_controller(span)
      return if Cloudtracer.config.blacklist_controllers.include? span.labels[:controller]
      span.name = "#{span.labels[:controller]}##{span.labels[:action]}"
      span.labels.except!(:headers, :params)
      span
    end

    def process_action_action_controller(span)
      return if Cloudtracer.config.blacklist_controllers.include? span.labels[:controller]
      span.name = "#{span.labels[:controller]}##{span.labels[:action]}"
      span.labels.except!(:headers, :params)
      span
    end

    def subscribe(topic)
      ActiveSupport::Notifications.subscribe(topic) do |name, started, finished, _id, data|
        update(name, started, finished, data)
      end
    end

    def to_method(name)
      name.tr('.', '_').to_sym
    end

    def clean_labels(data)
      data.inject({}) do |h, (key, value)|
        h[key.to_s] = value.to_s
        h
      end
    end
  end
end
