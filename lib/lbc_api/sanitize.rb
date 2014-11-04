module LbcApi
  class Sanitize
    def self.params(params)
      params.each do |k, v|
        if v.class == String
          params[k] = v.encode('iso-8859-15')
        elsif v.class == TrueClass
          params[k] = 1
        elsif v.class == FalseClass
          params[k] = 0
        end
      end
      params
    end
  end
end
