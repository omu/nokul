if Rails.env.development?
  Rails.application.configure do
    config.after_initialize do
      Bullet.enable = true
      Bullet.alert = true
      Bullet.bullet_logger = true
    end
  end
end
