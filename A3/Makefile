python:
	python3 Postgres.py

c:
	gcc -o Postgresc Postgres.c -I/usr/include/postgresql -lpq
	./Postgresc

cpp:
	g++ -o Postgrescpp Postgres.cpp -I/usr/include/postgresql -lpq
	./Postgrescpp

java:
	javac PostgresQueries.java
	java -cp ".:/usr/share/java/postgresql-jdbc4.jar" PostgresQueries

clean:
	rm -f Postgresc
	rm -f Postgrescpp
	rm -f PostgresQueries.class