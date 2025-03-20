require 'rails_helper'
require 'rake'

describe 'notify:like_ranking' do
  before do
    Rake.application.rake_require("tasks/like_ranking_notification")
    Rake::Task.define_task(:environment)
  end

  it 'メール通知が送信される' do
    expect { Rake::Task["notify:like_ranking"].invoke }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
