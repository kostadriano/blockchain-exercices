require_relative 'block-chain.rb'

PEOPLE =['Chase','Rennie','Franklin','Huynh','England','Lugo','Rodrigues','Betts','Cummings','Irwin','Nixon','Higgins','Cook','Ross','Eaton','Fountain']

block_chain = BlockChain.new

PEOPLE.each_with_index do |person, index|
  next_person = PEOPLE[index+1]

  if next_person.nil?
    next_person = PEOPLE.first
  end

  block = block_chain.create_block(sender:person, recipient: next_person)

  block_chain.add_block(block)
end
