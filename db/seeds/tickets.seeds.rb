after :users do
  Ticket.destroy_all
  ActiveRecord::Base.connection.execute 'ALTER TABLE tickets AUTO_INCREMENT = 1;'
  users = User.customers

  start_time = 3.months.ago
  finish_time = 1.week.ago
  current_time = start_time.dup

  count = 0

  while current_time < finish_time
    current_time = current_time + 2.days
    status = count % 3 == 0 ? 'open' : 'closed'
    user = users[count % users.count]

    FactoryGirl.create :ticket, status: status, user: user, created_at: current_time

    count += 1
  end

  puts "Created #{Ticket.count} tickets"
end
