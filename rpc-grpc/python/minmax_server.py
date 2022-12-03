from functools import reduce
import sys

from concurrent import futures
from math import inf, ceil
from typing import Iterable

import grpc
import minmax_pb2
import minmax_pb2_grpc


def find_minmax(numbers: Iterable[float]):
    numbers = sorted(numbers)
    return minmax_pb2.FindResponse(min=numbers[0], max=numbers[-1])

def merge_responses(response, parcial):
    response.min = min(parcial.min, response.min)
    response.max = max(parcial.max, response.max)
    return response

class MinMax(minmax_pb2_grpc.MinMaxService):

    def __init__(self, workers: futures.ProcessPoolExecutor, n_workers: int):
        self.workers = workers
        self.n_workers = n_workers

    def Find(self, request, context):
        length = len(request.numbers)

        print(f"INFO: {length} foram recebidos")

        offset = ceil(length/self.n_workers)
        numbers = (request.numbers[i*offset:(i+1)*offset] for i in range(self.n_workers))

        responses = self.workers.map(find_minmax, numbers)
        return reduce(merge_responses, responses, minmax_pb2.FindResponse(min=inf, max=-inf))

def serve():
    n_workers = int(sys.argv[1])
    workers = futures.ProcessPoolExecutor(max_workers=n_workers)
    
    server = grpc.server(futures.ThreadPoolExecutor())
    minmax_pb2_grpc.add_MinMaxService_to_server(MinMax(workers, n_workers), server)
    server.add_insecure_port(f'[::]:{sys.argv[2]}')
    server.start()
    server.wait_for_termination()

    workers.shutdown()


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print(f'Usage: {sys.argv[0]} N_WORKERS PORT')
        sys.exit(1)

    serve()
