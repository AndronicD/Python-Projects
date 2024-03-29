"""
This module represents the Consumer.

Computer Systems Architecture Course
Assignment 1
March 2021
"""

from threading import Thread, Lock
from time import sleep

class Consumer(Thread):
    """
    Class that represents a consumer.
    """

    def __init__(self, carts, marketplace, retry_wait_time, **kwargs):
        """
        Constructor.

        :type carts: List
        :param carts: a list of add and remove operations

        :type marketplace: Marketplace
        :param marketplace: a reference to the marketplace

        :type retry_wait_time: Time
        :param retry_wait_time: the number of seconds that a producer must wait
        until the Marketplace becomes available

        :type kwargs:
        :param kwargs: other arguments that are passed to the Thread's __init__()
        """
        Thread.__init__(self, **kwargs)
        self.carts = carts
        self.marketplace = marketplace
        self.retry_wait_time = retry_wait_time

    def run(self):
        """
        Pentru fiecare cart obtin un id, preiau parametrii din JSON
        si execut fiecare operatie. Incrementez valoarea current doar
        daca operatia a fost finalizata cu succes, iar la final apelez
        metoda place_order
        """
        for cart in self.carts:
            cart_id = self.marketplace.new_cart()

            for operation in cart:
                op_type = operation["type"]
                product = operation["product"]
                quantity = operation["quantity"]
                current = 0

                while current < quantity:
                    if op_type == "add":
                        is_product = self.marketplace.add_to_cart(cart_id, product)
                        if is_product is True:
                            current = current + 1
                        else:
                            sleep(self.retry_wait_time)
                    elif op_type == "remove":
                        self.marketplace.remove_from_cart(cart_id, product)
                        current = current + 1
            self.marketplace.place_order(cart_id)
            