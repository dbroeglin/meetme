DataMapper.logger = logger

case Padrino.env
  when :development then DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "meetme_development.db"))
  when :production  then DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "meetme_production.db"))
  when :test        then DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "meetme_test.db"))
end
