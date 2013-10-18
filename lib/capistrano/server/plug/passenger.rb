Configuration.instance(true).load do
  namespace :passenger do
    task :start do
      #noop
    end

    task :stop do
      #noop
    end

    task :restart do
      run %Q{touch "#{current_path}/tmp/restart.txt"}
    end

    task :status do
      #noop
    end
  end
end
