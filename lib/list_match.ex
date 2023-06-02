defmodule ListMatch do
  @moduledoc "Match two lists for one-to-one mapping"

  defmodule EnumFind do
    def match({list}) do
      a_list = list
      b_list= list

      Enum.map(a_list, fn (a) ->
        b = Enum.find(b_list, &(&1 == a))
        {a, b}
      end)
    end
  end

  defmodule For do
    def match({list}) do
      a_list = list
      b_list= list

      for a <- a_list, b <- b_list, a == b do
        {a, b}
      end
    end
  end

  defmodule Benchmark do
    @inputs %{
      "10" => {1..10},
      "100" => {1..100},
      "1000" => {1..1_000},
      "10k" => {1..10_000}
    }

    def benchmark do
      Benchee.run(
        %{
          "Enum.Find" => fn enumerator -> bench_func(enumerator, ListMatch.EnumFind) end,
          "For" => fn enumerator -> bench_func(enumerator, ListMatch.For) end
        },
        time: 10,
        inputs: @inputs,
        print: [fast_warning: false]
      )
    end

    def bench_func(list, module) do
      module.match(list)
    end
  end

  Enum.each(
    [ListMatch.EnumFind, ListMatch.For],
    fn module ->
      IO.inspect([{1, 1}, {2, 2}, {3, 3}, {4, 4}] == module.match({1..4}))
    end
  )

  ListMatch.Benchmark.benchmark()
end
