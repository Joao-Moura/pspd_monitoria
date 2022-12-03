from functools import reduce
import sys
import grpc
import minmax_pb2
import minmax_pb2_grpc

from concurrent import futures
from math import sqrt, ceil, inf
from random import uniform
from contextlib import contextmanager
from time import perf_counter

@contextmanager
def timeit():
    start = perf_counter()
    yield
    print(f"Tempo = {perf_counter() - start}s")


def merge_responses(response, parcial):
    response.min = min(parcial.min, response.min)
    response.max = max(parcial.max, response.max)
    return response


def run(args):
    numbers, target = args

    with grpc.insecure_channel(target, options=(('grpc.enable_http_proxy', 0),)) as channel:
        stub = minmax_pb2_grpc.MinMaxStub(channel)
        request = minmax_pb2.FindRequest(numbers=numbers)
        return stub.Find(request)


def main():
    MAX = 500_000
    numbers = [sqrt((i - uniform(0, MAX)/2)**2) for i in range(MAX)]

    n_workers = len(sys.argv) - 1
    hosts = sys.argv[1:]
    offset = ceil(MAX/n_workers)
    numbers = [numbers[i*offset:(i+1)*offset] for i in range(n_workers)]

    with futures.ProcessPoolExecutor(max_workers=n_workers) as executor, timeit():
        workers_args = zip(numbers, hosts)
        responses = executor.map(run, workers_args)

        final_response = reduce(merge_responses, responses, minmax_pb2.FindResponse(min=inf, max=-inf))
        print(f"MIN = {final_response.min}\nMAX = {final_response.max}")


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} IP:PORT...")
        sys.exit(1)

    main()
