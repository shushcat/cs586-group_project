PDF_ENGINE=typst

pdf:
	cd . && cp ../../ERD.png img/
	pandoc --pdf-engine=$(PDF_ENGINE) -o output.pdf README.md --listings
	rm ./img/ERD.png


clean:
	rm -rf output.*
