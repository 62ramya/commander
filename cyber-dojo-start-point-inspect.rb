
def cyber_dojo_start_point_inspect
  help = [
    '',
    "Use: #{me} start-point inspect NAME",
    '',
    'Displays details of the named start-point',
  ]

  vol = ARGV[2]
  if [nil,'--help'].include? vol
    show help
    exit succeeded
  end

  exit_unless_is_cyber_dojo_volume(vol, 'inspect')

  unless ARGV[3].nil?
    STDERR.puts "FAILED: unknown argument [#{ARGV[3]}]"
    exit failed
  end

  command =
  [
    'docker run',
    '--rm',
    "--user=root",
    "--volume=#{vol}:/data:#{read_only}",
    '--volume=/var/run/docker.sock:/var/run/docker.sock',
    "#{cyber_dojo_commander}",
    "sh -c './start_point_inspect.rb /data'"
  ].join(space=' ')
  print run(command)
end
