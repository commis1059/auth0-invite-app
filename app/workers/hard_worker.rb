class HardWorker
  include Sidekiq::Worker

  def perform
    puts "performed!!!"
  end
end
