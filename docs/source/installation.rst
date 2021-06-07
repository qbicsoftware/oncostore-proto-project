Installation
============

Requirements
------------

Variantstore runs on Java 8. Support for Java 9+ is experimental. Building Variantstore requires maven, however note that a maven wrapper is provided under the folder `.mvn <https://github.com/qbicsoftware/variantstore-service/tree/master/.mvn>`_.


Compile the Project
--------

.. code-block:: bash

    mvn clean compile

Build the Project
--------

.. code-block:: bash

   mvn clean package

Setup Database
--------

The complete installation of the Variantstore includes setting up the required databases to store the genomic information. Details can be found under :ref:`configuration`.

One-Click Deployment
--------

The Variantstore also supports a one-click deployment via docker-compose.
This allows fast setup of a functional variantstore & database infrastructure.

.. code-block:: bash

   cd variantstore-service/
   docker-compose up


However, it has to be noted that this kind of deployment is designed only for testing purposes.
For a productive environment, a manual setup with individual configuration is recommended.
