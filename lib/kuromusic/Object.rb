class Object
  def error_puts(name, message)
    STDERR.puts caller[1] + ": " + message + " for " + self.to_s + " (" + name + ")"
    exit(1)
  end
end
