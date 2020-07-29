namespace :db do
  task :dbm do
    require "dbm"
  end

  task :dump, [:name] => [:dbm, :json] do |t, args|
    name = args.name or abort "provide DB name"

    db = File.join "db", name

    DBM.open db, 0644, DBM::READER do |db|
      db.keys.sort.each do |id|
        value = db[id]

        puts "id: #{id}"

        if value.empty?
          "  [NEW RECORD]"
        else
          json = JSON.pretty_generate JSON.parse value
          json.lines.each do |line|
            puts "  #{line}"
          end
        end

        puts
      end
    end
  end

  task :clean, [:name] => [:dbm, :json] do |t, args|
    name = args.name or abort "provide DB name"

    db = File.join "db", name

    DBM.open db, 0644, DBM::WRITER do |db|
      db.delete_if do |key, value|
        value.empty?
      end
    end
  end

  task :json do
    require "json"
  end
end
