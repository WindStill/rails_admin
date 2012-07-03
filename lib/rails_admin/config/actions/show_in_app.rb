module RailsAdmin
  module Config
    module Actions
      class ShowInApp < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :visible? do
          authorized? && (bindings[:controller].main_app.url_for(bindings[:object]) rescue false)
        end

        register_instance_option :controller do
          Proc.new do
            p @object
            url = case @object
                  when User 
                    "users/#{@object.nickname}"
                  when Post
                    if @object.is_question?
                      "questions/#{@object.id}"
                    else
                      "answers/#{@object.id}"
                    end
                  else
                  end
            redirect_to "/#!/#{url}"
          end
        end

        register_instance_option :link_icon do
          'icon-eye-open'
        end
      end
    end
  end
end
