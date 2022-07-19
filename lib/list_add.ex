defmodule ListAdd.DoubleReverse do
  def add_lists(list) do
    Enum.reduce(list, [0], fn value, acc ->
      [value | Enum.reverse(acc)]
      |> Enum.reverse()
    end)
  end
end

defmodule ListAdd.Concat do
  def add_lists(list) do
    Enum.reduce(list, [0], fn value, acc ->
      acc ++ [value]
    end)
  end
end

# Basically it is just a wrapper of ++ so results would be the same.
defmodule ListAdd.EnumConcat do
  def add_lists(list) do
    Enum.reduce(list, [0], fn value, acc ->
      Enum.concat(acc, [value])
    end)
  end
end

defmodule ListAdd.Flatten do
  def add_lists(list) do
    Enum.reduce(list, [0], fn value, acc ->
      List.flatten([acc, value])
    end)
  end
end

defmodule ListAdd.Benchmark do
  @inputs %{
    "10k" => 1..10_000,
    "1000" => 1..1_000,
    "100" => 1..100,
    "10" => 1..10
  }

  def benchmark do
    Benchee.run(
      %{
        "Double Reverse" => fn enumerator -> bench_func(enumerator, ListAdd.DoubleReverse) end,
        "Concatenation" => fn enumerator -> bench_func(enumerator, ListAdd.Concat) end,
        "EnumConcatenation" => fn enumerator -> bench_func(enumerator, ListAdd.EnumConcat) end,
        "Flatten" => fn enumerator -> bench_func(enumerator, ListAdd.Flatten) end
      },
      time: 10,
      inputs: @inputs,
      print: [fast_warning: false]
    )
  end

  def bench_func(list, module) do
    module.add_lists(list)
  end
end

Enum.each(
  [ListAdd.DoubleReverse, ListAdd.Concat, ListAdd.EnumConcat, ListAdd.Flatten],
  fn module ->
    IO.inspect([0, 1, 2, 3, 4] == module.add_lists(1..4))
  end
)

 ListAdd.Benchmark.benchmark()
