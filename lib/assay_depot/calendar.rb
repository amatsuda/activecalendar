# Calendar

require "date"

module ActionView
  module Helpers
    module DepotDateHelper
      def depot_date_select(options = {})
        if(options[:id].blank?)
          options[:id] = options[:name]
        end

        if value(object) == nil
          date = ""
        else
          date = value(object).strftime("%a %B %d %Y")
        end

				html  = %(<input type="text" name="#{options[:name]}" value="#{date}" class="#{options[:class]} text-input" id="#{options[:id]}" readonly="1" />\n)
        html << %(<img src="/images/calendar.png" id="#{options[:id]}_trigger" style="cursor: pointer;" title="Date selector" />\n)
        html << %(<script type="text/javascript">\n)
        html << %(    Calendar.setup\({\n)
        html << %(        inputField     :    "#{options[:id]}",     // id of the input field\n)
        html << %(        ifFormat       :    "%m/%d/%Y",      // format of the input field\n)
        html << %(        button         :    "#{options[:id]}_trigger",  // trigger for the calendar, button ID\n)
        html << %(        singleClick    :    true\n)
        html << %(    }\);\n)
        html << %(</script>\n)
        
        html
      end
      
      def depot_datetime_select(options = {})
        if(options[:id].blank?)
          options[:id] = options[:name]
        end

        if value(object) == nil
          datetime = ""
        else
          datetime = value(object).strftime("%a %B %d %Y %I:%M %p")
        end

        html  = %(<input type="text" name="#{options[:name]}" value="#{datetime}" class="#{options[:class]} text-input" id="#{options[:id]}" readonly="1" />\n)
        html << %(<img src="/images/calendar.png" id="#{options[:id]}_trigger" style="cursor: pointer;" title="Date & Time selector" />\n)
        html << %(<script type="text/javascript">\n)
        html << %(    Calendar.setup\({\n)
        html << %(        inputField     :    "#{options[:id]}",     // id of the input field\n)
        html << %(        ifFormat       :    "%m/%d/%Y %I:%M %p",      // format of the input field\n)
        html << %(        button         :    "#{options[:id]}_trigger",  // trigger for the calendar, button ID\n)
        html << %(        singleClick    :    true, \n)
        html << %(        showsTime      :    true, \n)
        html << %(        time24         :    false \n)
        html << %(    }\);\n)
        html << %(</script>\n)
        
        html
      end
    end

    module DateHelper
      def date_select(object_name, method, options = {})
        name = "#{object_name}[#{method}]"
        id = "#{object_name}_#{method}"
        options = options.merge( { :name => name, :id => id, :method => method, :object_name => object_name })
        InstanceTag.new(object_name, method, self, nil, options.delete(:object)).to_date_select_tag(options)
      end

      def datetime_select(object_name, method, options = {})
        name = "#{object_name}[#{method}]"
        id = "#{object_name}_#{method}"
        options = options.merge( { :name => name, :id => id, :method => method, :object_name => object_name })
        InstanceTag.new(object_name, method, self, nil, options.delete(:object)).to_datetime_select_tag(options)
      end
    end

    class InstanceTag #:nodoc:
      include DepotDateHelper

      def to_date_select_tag(options = {})
        depot_date_select options
      end

      def to_datetime_select_tag(options = {})
        depot_datetime_select options
      end
    end
  end
end