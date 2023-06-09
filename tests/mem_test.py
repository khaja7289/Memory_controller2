import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge
from cocotb.result import TestFailure, TestSuccess

@cocotb.test()
async def memory_controller_test(dut):
    clock = Clock(dut.clk, 10, units="ns")  # Create a clock with 10ns period
    cocotb.fork(clock.start())  # Start the clock

    # Reset the memory controller
    dut.reset <= 1
    await RisingEdge(dut.clk)
    dut.reset <= 0
    await RisingEdge(dut.clk)

    # Perform write operation
    dut.address <= 0x00000001
    dut.write_data <= 0xDEADBEEF
    dut.write_enable <= 1
    await RisingEdge(dut.clk)
    dut.write_enable <= 0

    # Perform read operation
    dut.address <= 0x00000001
    dut.read_enable <= 1
    await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    read_data = dut.read_data.value

    # Verify the read data
    expected_data = 0xDEADBEEF
    if read_data != expected_data:
        raise TestFailure(f"Read data mismatch. Expected: {expected_data}, Got: {read_data}")
    else:
        raise TestSuccess("Memory controller test passed!")
