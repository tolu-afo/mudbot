defmodule MudbotTest do
  use ExUnit.Case
  alias Mudbot, as: TestSubject
  import Mox

  # Set up a mock for EventSupervisor
  defmodule MockEventSupervisor do
    import Mox
    def start_link(_arg) do
      {:ok, self()}
    end
  end

  setup do
    # Start the Mox server
    Mox.Server.start_link()

    # Inject the mock module into the EventSupervisor alias
    {:ok, [EventSupervisor: MockEventSupervisor]}
  end

  test "start/2 returns {:ok, self()} on successful startup" do
    # Arrange: Set up the expected behavior for the mock
    expect(MockEventSupervisor, :start_link, fn _ ->
      {:ok, self()}
    end)

    # Act: Call Mudbot.start/2 with the mock module
    {:ok, _} = TestSubject.start(:normal, EventSupervisor)

    # Assert: Check if the message "Mudbot started successfully" is printed to stdout
    assert captured_output = ExUnit.CaptureIO.capture_io(fn ->
      :timer.sleep(100)  # Wait briefly for the IO message
    end)
    assert String.contains?(captured_output, "Mudbot started successfully")

    # Verify that the expected function in the mock was called
    Mox.assert_called(MockEventSupervisor, :start_link, 1)
  end

  test "start/2 returns {:error, reason} on failed startup" do
    # Arrange: Set up the expected behavior for the mock to return an error
    expect(MockEventSupervisor, :start_link, fn _ ->
      {:error, :some_reason}
    end)

    # Act: Call Mudbot.start/2 with the mock module
    {:error, reason} = TestSubject.start(:normal, EventSupervisor)

    # Assert: Check if the message "Mudbot failed to start: #{reason}" is printed to stdout
    assert captured_output = ExUnit.CaptureIO.capture_io(fn ->
      :timer.sleep(100)  # Wait briefly for the IO message
    end)
    assert String.contains?(captured_output, "Mudbot failed to start")

    # Verify that the expected function in the mock was called
    Mox.assert_called(MockEventSupervisor, :start_link, 1)

    # Verify that the reason matches the expected reason
    assert reason == :some_reason
  end
end
