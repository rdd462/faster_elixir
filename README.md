# FasterElixir

This repository is based on the project [fast-elixir](https://github.com/devonestes/fast-elixir) where you can find some benchmarks.
Here I'm trying to check other solutions of some controversial approaches of using elixir.

## Combining lists with `|` vs `++` vs other approaches
There are different ways of adding new element to a list. Usually it is a `++` concatenation that adds a list at the end of another list or `|` concatenation that adds an element at the beginning of a list.
To keep the same order we have to use reverse function for the second option which adds more reductions but according to [this benchmark](https://github.com/devonestes/fast-elixir/blob/master/README.md#combining-lists-with--vs--code)
it is still faster that `++`.  
Performance of different approaches also depends on the adding element type, and there will be a difference if it is a list or a single element.
In the mentioned benchmark the adding element was a list, so let's try to check the other case when the new element is not a list.

```shell
$ mix run lib/list_add.ex
Operating System: macOS
CPU Information: Apple M1 Pro
Number of Available Cores: 10
Available memory: 16 GB
Elixir 1.13.2
Erlang 24.2.1

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 10 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: 10, 100, 1000, 10k
Estimated total run time: 3.20 min

Benchmarking Concatenation with input 10 ...
Benchmarking Concatenation with input 100 ...
Benchmarking Concatenation with input 1000 ...
Benchmarking Concatenation with input 10k ...
Benchmarking Double Reverse with input 10 ...
Benchmarking Double Reverse with input 100 ...
Benchmarking Double Reverse with input 1000 ...
Benchmarking Double Reverse with input 10k ...
Benchmarking EnumConcatenation with input 10 ...
Benchmarking EnumConcatenation with input 100 ...
Benchmarking EnumConcatenation with input 1000 ...
Benchmarking EnumConcatenation with input 10k ...
Benchmarking Flatten with input 10 ...
Benchmarking Flatten with input 100 ...
Benchmarking Flatten with input 1000 ...
Benchmarking Flatten with input 10k ...

##### With input 10 #####
Name                        ips        average  deviation         median         99th %
Concatenation            2.92 M      342.45 ns    ±90.01%         310 ns         690 ns
EnumConcatenation        2.81 M      356.01 ns    ±59.06%         330 ns         700 ns
Double Reverse           2.09 M      478.52 ns    ±10.76%         470 ns         700 ns
Flatten                  0.95 M     1054.70 ns   ±217.09%        1000 ns        1900 ns

Comparison: 
Concatenation            2.92 M
EnumConcatenation        2.81 M - 1.04x slower +13.56 ns
Double Reverse           2.09 M - 1.40x slower +136.07 ns
Flatten                  0.95 M - 3.08x slower +712.25 ns

##### With input 100 #####
Name                        ips        average  deviation         median         99th %
Concatenation           99.96 K       10.00 μs   ±157.64%           9 μs          45 μs
EnumConcatenation       96.91 K       10.32 μs   ±264.82%           9 μs          46 μs
Double Reverse          50.36 K       19.86 μs    ±74.99%          17 μs          54 μs
Flatten                 21.94 K       45.57 μs    ±47.85%          45 μs          55 μs

Comparison: 
Concatenation           99.96 K
EnumConcatenation       96.91 K - 1.03x slower +0.31 μs
Double Reverse          50.36 K - 1.98x slower +9.85 μs
Flatten                 21.94 K - 4.56x slower +35.57 μs

##### With input 1000 #####
Name                        ips        average  deviation         median         99th %
Concatenation            999.27        1.00 ms    ±14.41%        1.00 ms        1.30 ms
EnumConcatenation        985.42        1.01 ms    ±14.11%        1.04 ms        1.29 ms
Double Reverse           443.01        2.26 ms     ±8.74%        2.31 ms        2.57 ms
Flatten                  232.56        4.30 ms     ±1.90%        4.28 ms        4.55 ms

Comparison: 
Concatenation            999.27
EnumConcatenation        985.42 - 1.01x slower +0.0141 ms
Double Reverse           443.01 - 2.26x slower +1.26 ms
Flatten                  232.56 - 4.30x slower +3.30 ms

##### With input 10k #####
Name                        ips        average  deviation         median         99th %
Concatenation              8.52      117.34 ms     ±0.54%      117.31 ms      121.25 ms
EnumConcatenation          8.50      117.65 ms     ±0.97%      117.39 ms      122.89 ms
Double Reverse             4.70      212.70 ms     ±1.05%      212.00 ms      222.19 ms
Flatten                    2.11      472.98 ms     ±0.42%      471.98 ms      479.34 ms

Comparison: 
Concatenation              8.52
EnumConcatenation          8.50 - 1.00x slower +0.32 ms
Double Reverse             4.70 - 1.81x slower +95.37 ms
Flatten                    2.11 - 4.03x slower +355.65 ms
```