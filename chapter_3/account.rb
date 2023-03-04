class Account                               
  attr_accessor :balance          # Protected variable @balance made accessible (reading and writing) through attr_accessor
  def initialize(balance)                   # It is passed as an argument at initialization. 
    @balance = balance                      # The instance variable @balance value equals the argument value. 
  end
  def greater_balance_than?(other)          
    @balance > other.balance
  end
end
    
class Transaction                           
  def initialize(account_a, account_b)      # Two variables are passed as arguments during initialization, representing accounts. 
    @account_a = account_a
    @account_b = account_b
  end
  def transfer(amount)                      # A transferrable amount is passed as an argument for this method
    debit(@account_a, amount)               # A private method `debit` is called, assigning the first account an amount (in this case checking: 200)
    credit(@account_b, amount)              # A private method `credit` is called, assigning the second account an amount (in this case savings: 200)
  end
  private def debit(account, amount)        # Trying to call either this or the credit method independently will crash the program. They are  
    account.balance -= amount               # given access control only through the public method `transfer.`
  end
  private def credit(account, amount)       
    account.balance += amount
  end
end
    
savings = Account.new(100)                  # The savings account starts out with 100 
checking = Account.new(200)                 # The checking account starts out with 200 
transaction = Transaction.new(checking, savings) # The transaction instance is initialized, accepting both as arguments. 
puts transaction.transfer(50)               # The amount of the checking -> savings transfer is passed at the method's execution. 


puts savings.greater_balance_than?(checking)   # Fun method that checks if account_b has more than account_a