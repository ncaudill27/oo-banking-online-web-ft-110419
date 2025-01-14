require 'pry'
class Transfer

  @@completed_transfers = []

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid? && sender.balance >= amount
  end

  def execute_transaction
    if valid? && self.status != 'complete'
      sender.balance -= amount
      receiver.balance += amount
      self.status =  'complete'
      @@completed_transfers << self
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    unless self.status == 'pending'
      last = @@completed_transfers.pop
      sender.balance += amount
      receiver.balance -= amount
      self.status = 'reversed'
    end
  end

end
