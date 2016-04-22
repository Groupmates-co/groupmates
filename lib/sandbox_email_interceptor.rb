class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = ['thomas@quiroga.fr']
  end
end