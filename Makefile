NAME = alanswx/misterpdf
VERSION = 1.0
pwd=`pwd`

tag-latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

build:
	docker build  -t $(NAME):$(VERSION) --force-rm --compress image

run:
	docker run -it --rm -v ${pwd}:/mister $(NAME):latest

getexec:
	docker run -it --rm -v ${pwd}:/mister $(NAME):latest bash -c "cp /usr/local/src/jfbview/build/src/jfbview /mister/jfbview.exec"
