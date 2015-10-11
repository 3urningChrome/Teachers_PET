class SuspendedCheckGuard < Clearance::SignInGuard
  def call
    if suspended?
      failure("Your account is suspended.")
    else
      next_guard
    end
  end

  def suspended?
    return false if current_user.nil?
    puts "current_user: #{current_user}"
    current_user.suspended?
  end
end

Clearance.configure do |config|
  config.sign_in_guards = [SuspendedCheckGuard]
  config.routes = false
  config.mailer_sender = "3urning.chrome@gmail.com"
end
