
require 'mysql'

@db = Mysql.new("mysqlsrv.ece.ualberta.ca", "ece421grp1" , "Uje99Wzb", "ece421grp1", 13010)

#@db.select_db("ece421grp1")

@db.list_dbs
###=> ["information_schema", "ece421grp1"]

 @db.query("DROP TABLE IF EXISTS animal")
   @db.query("CREATE TABLE animal
              (
                name     CHAR(40),
                category CHAR(40)
              )
            ")
   @db.query("INSERT INTO animal (name, category)
                VALUES
                  ('snake', 'reptile'),
                  ('frog', 'amphibian'),
                  ('tuna', 'fish'),
                  ('racoon', 'mammal')
              ")
   puts "Number of rows inserted: #{@db.affected_rows}"

res = @db.query('describe animal')

# if you try 'describe animal;' in mysql, you will see what is going on
#
res.each {|l| puts l}

# Free up 'res' as an example
# puts "Before res.free -> Number of rows returned: #{res.num_rows}"

###res.free # free up res

# puts "After res.free -> Number of rows returned: #{res.num_rows}"
# The above prints a MySQL error not a ruby error - interesting

#  fetch_row and each return successive rows of the result, each row as
#  an array of column values. There are hashed versions of each
#  of these that return rows as hashes keyed by column
#  name. The hash method, fetch_hash is used like this:
res = @db.query('select * from animal')
res.each_hash {|h| puts h['name']}
#snake
#frog
#tuna
#racoon

 # issue a retrieval query, perform a fetch loop, print
 # the row count, and free the result set
while row = res.fetch_row do
  printf "%s %s\n", row[0], row[1]
end

#snake reptile
#frog amphibian
#tuna fish
#racoon mammal

puts "Number of rows returned: #{res.num_rows}"

#Finally, close the database
@db.close if @db


# As an exercise, try experimenting with the code below. It's tested and it works.
#
# @db.query("DROP TABLE IF EXISTS junk")
#   @db.query("CREATE TABLE junk
#              (
#                name     CHAR(40),
#                category CHAR(40)
#              )
#            ")
#   @db.query("INSERT INTO junk (name, category)
#                VALUES
#                  ('dog', 'popular'),
#                  ('cat', 'common'),
#                  ('bird', 'noisy'),
#                  ('hare', 'omnipresent')
#              ")
#   puts "Number of rows inserted: #{@db.affected_rows}"

