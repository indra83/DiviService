desc 'Auto expire lectures older than one hour'
task autoexpire_lectures: [:environment] do
  Lecture.live.old.each &:expire!
end
