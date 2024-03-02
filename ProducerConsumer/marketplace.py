"""
This module represents the Marketplace.

Computer Systems Architecture Course
Assignment 1
March 2021
"""
from threading import Lock, currentThread
import logging
import time
from logging.handlers import RotatingFileHandler
import unittest
from src.product import Tea, Coffee

class Marketplace:
    """
    Class that represents the Marketplace. It's the central part of the implementation.
    The producers and consumers use its methods concurrently.
    """
    def __init__(self, queue_size_per_producer):
        """
        Constructor

        :type queue_size_per_producer: Int
        :param queue_size_per_producer: the maximum size of a queue associated with each producer
        """
        self.queue_size_per_producer = queue_size_per_producer
        self.producer_id = 0 #counter pentru id producer
        self.producer_id_lock = Lock() #lock pentru incrementare id producer
        self.cart_id = 0 #counter pentru id cart
        self.cart_id_lock = Lock() #lock pentru incrementare id cart
        self.producer_products = {} #dictionar in care retin id-ul producatorului si produsele asociate
        self.cart_products = {} #dictionar in care retin id-ul cartului si produsele asociate
        self.publish_lock = Lock() #lock pentru operatia de publish
        self.add_lock = Lock() #lock pentru operatia de add_to_cart
        self.remove_lock = Lock() #lock pentru operatia de remove_from_cart
        self.list_lock = Lock() #lock pentru operatia de place_order
        #setare logger
        self.logger = logging.getLogger('logger')
        self.logger.setLevel(logging.INFO)
        self.handler = RotatingFileHandler(filename='marketplace.log',
                                           maxBytes=500000, backupCount=10)
        self.handler.setLevel(logging.INFO)
        self.formatter = logging.Formatter('%(asctime)s - %(message)s')
        self.formatter.converter = time.gmtime  # use gmtime instead of localtime
        self.handler.setFormatter(self.formatter)
        self.logger.addHandler(self.handler)

    def register_producer(self):
        """
        Returns an id for the producer that calls this.
        
        Incrementez valoarea curenta a id-ului de 
        producer si o intorc.
        """
        with self.producer_id_lock:
            ret = self.producer_id
            self.producer_id = self.producer_id + 1
        self.logger.info('Register ret: %d', ret)
        return ret

    def publish(self, producer_id, product):
        """
        Adds the product provided by the producer to the marketplace

        :type producer_id: String
        :param producer_id: producer id

        :type product: Product
        :param product: the Product that will be published in the Marketplace

        :returns True or False. If the caller receives False, it should wait and then try again.

        In cazul in care nu am o cheie cu id-ul producerului
        adaug in dictionar cheia cu o lista vida, iar daca
        mai e loc in in lista public produsul si intorc True
        altfel False.
        """
        self.logger.info('Publish Prod-Id: %s', producer_id)
        self.logger.info('Product: %s', product)
        ret = False
        with self.publish_lock:
            if producer_id not in self.producer_products.keys():
                self.producer_products[producer_id] = []
            if len(self.producer_products[producer_id]) < self.queue_size_per_producer:
                ret = True
                self.producer_products[producer_id].append(product)
        self.logger.info('Publish return: %d', ret)
        return ret

    def new_cart(self):
        """
        Creates a new cart for the consumer

        :returns an int representing the cart_id

        Incrementez valoarea curenta a id-ului de 
        cart si o intorc.
        """
        with self.cart_id_lock:
            ret = self.cart_id
            self.cart_id = self.cart_id + 1
        self.logger.info('New Cart return: %d', ret)
        return ret

    def add_to_cart(self, cart_id, product):
        """
        Adds a product to the given cart. The method returns

        :type cart_id: Int
        :param cart_id: id cart

        :type product: Product
        :param product: the product to add to cart

        :returns True or False. If the caller receives False, it should wait and then try again

        In cazul in care nu am o cheie cu id-ul cartului
        adaug in dictionar cheia cu o lista vida, iar daca
        gasesc produsul in lista de produse al unui producator
        (primul la care apare) scot produsul din lista producatorului
        adaug produsul in cart retinand un tuplu de forma (produs, id_producator)
        astfel incat in cazul de remove sa stiu unde sa intorc produsul.
        """
        ret = False
        found = False
        self.logger.info('Add-to-cart Product: %s', product)
        self.logger.info('Cart-Id: %s', cart_id)
        with self.add_lock:
            if cart_id not in self.cart_products.keys():
                self.cart_products[cart_id] = []
            for producer_id, product_list in self.producer_products.items():
                for elem in product_list:
                    if elem == product:
                        ret = True
                        self.producer_products[producer_id].remove(product)
                        self.cart_products[cart_id].append((product, producer_id))
                        found = True
                        break
                if found is True:
                    break
        self.logger.info('Add-to-cart return: %d', ret)
        return ret

    def remove_from_cart(self, cart_id, product):
        """
        Removes a product from cart.

        :type cart_id: Int
        :param cart_id: id cart

        :type product: Product
        :param product: the product to remove from cart
        
        In cazul in care gasesc produsul in cart intorc 
        produsul in lista producatorului si il sterg din 
        cart.
        """
        self.logger.info('Remove-from-cart Cart-Id: %s', cart_id)
        self.logger.info('Remove-from-cart Product: %s', product)
        id_producer = -1
        with self.remove_lock:
            for pereche in self.cart_products[cart_id]:
                prod, id_prod = pereche
                if prod == product:
                    id_producer = id_prod
                    self.cart_products[cart_id].remove((product, id_producer))
                    self.producer_products[id_producer].append(product)
                    break

    def place_order(self, cart_id):
        """
        Return a list with all the products in the cart.

        :type cart_id: Int
        :param cart_id: id cart

        Elimin elementul din dictionarul de carturi, afisez 
        doar produsele din tuplul (produs, id_producator) si 
        retin produsele intr-o noua lista pe care o intorc.
        """
        self.logger.info('Place-Order Cart-Id: %s', cart_id)
        new_product = []
        with self.list_lock:
            products = self.cart_products.pop(cart_id, None)
            for product, _ in products:
                print(f"{currentThread().getName()} bought {product}")
                new_product.append(product)
        self.logger.info('Place order -> List of new products : %s', new_product)
        return new_product

class TestMarketplace(unittest.TestCase):
    """
    Class that represents the Unittesting Class for the Marketplace where
    I created tests for every method in which I check every output.
    """
    def setUp(self):
        """
        Sets up a Marketplace object that allows producers to have
        3 items at most.
        """
        self.marketplace = Marketplace(3)

    def test_register_producer(self):
        """
        Tests if the current number of registered producers increases.
        """
        producer_1 = self.marketplace.register_producer()
        self.assertEqual(producer_1, 0)
        producer_2 = self.marketplace.register_producer()
        self.assertEqual(producer_2, 1)

    def test_publish(self):
        """
        Tests if the current number of registered producers increases
        if the number of items stored is correct and if it allows the
        registered producer to have more items than the maxium value
        allowed.
        """
        producer_1 = self.marketplace.register_producer()
        self.assertEqual(producer_1, 0)
        producer_2 = self.marketplace.register_producer()
        self.assertEqual(producer_2, 1)
        product_1 = Tea(name="Ceai 1", price=30, type="Bun")
        product_2 = Tea(name="Ceai 2", price=20, type="Bunicel")
        product_3 = Coffee(name="Cafea 1", price=40, acidity="0.1", roast_level="9")
        product_4 = Coffee(name="Cafea 2", price=35, acidity="0.2", roast_level="8")
        self.assertTrue(self.marketplace.publish("0", product_1))
        self.assertTrue(self.marketplace.publish("0", product_2))
        self.assertTrue(self.marketplace.publish("0", product_3))
        self.assertFalse(self.marketplace.publish("0", product_4))
        self.assertTrue(self.marketplace.publish("1", product_1))
        self.assertTrue(self.marketplace.publish("1", product_2))
        self.assertEqual(len(self.marketplace.producer_products["1"]), 2)

    def test_new_cart(self):
        """
        Tests if the current number of carts increases.
        """
        cart_1 = self.marketplace.new_cart()
        self.assertEqual(cart_1, 0)
        cart_2 = self.marketplace.new_cart()
        self.assertEqual(cart_2, 1)

    def test_add_to_cart(self):
        """
        Tests the add to cart functionality, if the method adds
        items to a cart even if there is not a producer who has 
        the item, if the number of products in a cart is correct
        and if it finds products from different producers.
        """
        self.marketplace.register_producer()

        product_1 = Tea(name="Ceai 1", price=30, type="Bun")
        product_2 = Coffee(name="Cafea 1", price=40, acidity="0.1", roast_level="9")

        self.marketplace.publish("0", product_1)
        self.marketplace.publish("0", product_1)
        self.marketplace.publish("0", product_1)

        self.marketplace.new_cart()
        self.assertTrue(self.marketplace.add_to_cart("0", product_1))
        self.assertTrue(self.marketplace.add_to_cart("0", product_1))
        self.assertFalse(self.marketplace.add_to_cart("0", product_2))

        self.assertEqual(len(self.marketplace.cart_products["0"]), 2)

        self.marketplace.register_producer()
        self.marketplace.publish("1", product_2)
        self.assertTrue(self.marketplace.add_to_cart("0", product_2))
        self.assertEqual(len(self.marketplace.cart_products["0"]), 3)

    def test_remove_from_cart(self):
        """
        Tests the add_to_cart functionality and the remove_from_cart
        and if an object is not currently in the cart to not remove 
        anything.
        """
        self.marketplace.register_producer()

        product_1 = Tea(name="Ceai 1", price=30, type="Bun")
        product_2 = Coffee(name="Cafea 1", price=40, acidity="0.1", roast_level="9")
        product_3 = Coffee(name="Cafea 2", price=35, acidity="0.2", roast_level="8")

        self.marketplace.publish("0", product_1)
        self.marketplace.publish("0", product_1)
        self.marketplace.publish("0", product_2)

        self.marketplace.new_cart()
        self.assertTrue(self.marketplace.add_to_cart("0", product_1))
        self.assertTrue(self.marketplace.add_to_cart("0", product_1))
        self.assertTrue(self.marketplace.add_to_cart("0", product_2))

        self.marketplace.remove_from_cart("0", product_1)
        self.assertEqual(len(self.marketplace.cart_products["0"]), 2)
        self.marketplace.remove_from_cart("0", product_1)
        self.assertEqual(len(self.marketplace.cart_products["0"]), 1)
        self.marketplace.remove_from_cart("0", product_3)
        self.assertEqual(len(self.marketplace.cart_products["0"]), 1)
        self.marketplace.remove_from_cart("0", product_2)
        self.assertEqual(len(self.marketplace.cart_products["0"]), 0)

    def test_place_order(self):
        """
        Tests is the number of products in the cart is correct
        and if the cart is still stored in cart_products (dictionary
        for cart and their products)
        """
        self.marketplace.register_producer()

        product_1 = Tea(name="Ceai 1", price=30, type="Bun")
        product_2 = Coffee(name="Cafea 1", price=40, acidity="0.1", roast_level="9")

        self.marketplace.publish("0", product_1)
        self.marketplace.publish("0", product_2)

        self.marketplace.new_cart()
        self.assertTrue(self.marketplace.add_to_cart("0", product_1))
        self.assertTrue(self.marketplace.add_to_cart("0", product_2))

        self.assertTrue(len(self.marketplace.place_order("0")), 2)
        self.assertNotIn("0", self.marketplace.cart_products)
