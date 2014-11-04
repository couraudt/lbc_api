module LbcApi
  class Agent
    def self.mecha
      Mechanize.new do |agent|
        agent.user_agent_alias = 'Mac Safari'
        agent.follow_meta_refresh = true
      end
    end
  end
end
