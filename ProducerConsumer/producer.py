"""
This module represents the Producer.

Computer Systems Architecture Course
Assignment 1
March 2021
"""

from threading import Thread
from time import sleep


class Producer(Thread):
    """
    Class that represents a producer.
    """

    def __init__(self, products, marketplace, republish_wait_time, **kwargs):
        """
        Constructor.

        @type products: List()
        @param products: a list of products that the producer will produce

        @type marketplace: Marketplace
        @param marketplace: a reference to the marketplace

        @type republish_wait_time: Time
        @param republish_wait_time: the number of seconds that a producer must
        wait until the marketplace becomes available

        @type kwargs:
        @param kwargs: other arguments that are passed to the Thread's __init__()
        """
        Thread.__init__(self, **kwargs)
        self.products = products
        self.marketplace = marketplace
        self.republish_wait_time = republish_wait_time

    def run(self):
        """
        Obtin un id pentru producator si intr-o bucla
        infinita preiau argumentele din JSON. Daca producatorul
        are spatiu pentru a produce ramane blocat un timp
        egal cu production_time, altfel ramane blocat un timp
        egal cu republish_wait_time.
        """
        prod_id = self.marketplace.register_producer()

        while True:
            for product in self.products:
                prod = product[0]
                quantity = product[1]
                production_time = product[2]

                current = 0
                while current < quantity:
                    is_space = self.marketplace.publish(prod_id, prod)

                    if is_space is True:
                        current = current + 1
                        sleep(production_time)
                    else:
                        sleep(self.republish_wait_time)
