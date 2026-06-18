require "./spec_helper"

describe Marten::CLI::Manage::Command::Play do
  describe "#run" do
    it "starts the Crystal playground as expected when no host/port are provided" do
      stdout = IO::Memory.new
      stderr = IO::Memory.new

      command = Marten::CLI::Manage::Command::Play.new(
        options: [] of String,
        stdout: stdout,
        stderr: stderr
      )

      spawn { command.handle }

      sleep(Time::Span.new(nanoseconds: 1_000_000_000))

      # Le processus du playground peut s'être déjà arrêté avant ce
      # terminate (course de timing en CI) ; on ignore alors l'erreur
      # « No such process » — le test vérifie l'absence d'erreur sur stderr.
      command.playground_process.try { |process| process.terminate rescue nil }

      stderr.rewind.gets_to_end.empty?.should be_true
    end

    it "starts the Crystal playground as expected when a host is provided" do
      stdout = IO::Memory.new
      stderr = IO::Memory.new

      command = Marten::CLI::Manage::Command::Play.new(
        options: ["--bind", "localhost"],
        stdout: stdout,
        stderr: stderr
      )

      spawn { command.handle }

      sleep(Time::Span.new(nanoseconds: 1_000_000_000))

      # Le processus du playground peut s'être déjà arrêté avant ce
      # terminate (course de timing en CI) ; on ignore alors l'erreur
      # « No such process » — le test vérifie l'absence d'erreur sur stderr.
      command.playground_process.try { |process| process.terminate rescue nil }

      stderr.rewind.gets_to_end.empty?.should be_true
    end

    it "starts the Crystal playground as expected when a port is provided" do
      stdout = IO::Memory.new
      stderr = IO::Memory.new

      command = Marten::CLI::Manage::Command::Play.new(
        options: ["--port", "3000"],
        stdout: stdout,
        stderr: stderr
      )

      spawn { command.handle }

      sleep(Time::Span.new(nanoseconds: 1_000_000_000))

      # Le processus du playground peut s'être déjà arrêté avant ce
      # terminate (course de timing en CI) ; on ignore alors l'erreur
      # « No such process » — le test vérifie l'absence d'erreur sur stderr.
      command.playground_process.try { |process| process.terminate rescue nil }

      stderr.rewind.gets_to_end.empty?.should be_true
    end

    it "starts the Crystal playground as expected when a host and port are provided" do
      stdout = IO::Memory.new
      stderr = IO::Memory.new

      command = Marten::CLI::Manage::Command::Play.new(
        options: ["--bind", "localhost", "--port", "3000"],
        stdout: stdout,
        stderr: stderr
      )

      spawn { command.handle }

      sleep(Time::Span.new(nanoseconds: 1_000_000_000))

      # Le processus du playground peut s'être déjà arrêté avant ce
      # terminate (course de timing en CI) ; on ignore alors l'erreur
      # « No such process » — le test vérifie l'absence d'erreur sur stderr.
      command.playground_process.try { |process| process.terminate rescue nil }

      stderr.rewind.gets_to_end.empty?.should be_true
    end
  end
end
