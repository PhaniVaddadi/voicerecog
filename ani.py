import ray

ray.init()

# Define functions you want to execute in parallel using 
# the ray.remote decorator.
@ray.remote
def func1():
    print("Working")

@ray.remote
def func2():
    print("Working")

# Execute func1 and func2 in parallel.
ray.get([func1.remote(), func2.remote()])