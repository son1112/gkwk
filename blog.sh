#!/bin/bash
#blog.sh

# sonander's WEB LOG:

# Ideal Procedure

# From the command line, give the command "blog" or "blog.sh", running this script 
# Emacs would open to a clean blank file with a unique name to the blog "post" file (based on date)

NOW=$(date +"%h-%d-%Y_%H%M")
BLOGDIR=$HOME/son-pub/blog
BLOG=$BLOGDIR/blog.html
HEAD=$BLOGDIR/blog-head.html
TODAY=$BLOGDIR/$NOW.html
POSThead=$BLOGDIR/post-head.html
TAIL=$BLOGDIR/blog-tail.html
TAILbak=$BLOGDIR/blog-tail.html.bak

$HOME/bin/GEEK-rapid.sh "$1" &

#TODO: emacs, current line, display in mode-line in larger format "zooming in" if you will

# function video_cat () {
#     printf '\n<video class="post-vid" width="644" height="540" controls autoplay loop>\n<source src="../vids/' >> $BLOG &&
#     printf $1 >> $BLOG &&
#     printf '.webm" type="video/webm">\n</video>\n\n' >> $BLOG
# }    


if [ ! "$(ps aux | grep "emacs" | grep -v grep | awk '{ print $11 }')" ]; then

    emacs --daemon &&
    sh $HOME/bin/blog

else

    echo "<h2 class='date'><em>$(date +"%h %d %Y %H:%M")</em></h2>" > $POSThead &&

    echo ""
    echo "Post Title:"
    echo ""
    read title
    echo ""
    echo "<h1 class='post-title'>$1</h1>" >> $POSThead &&

#there has got to be a better way to go about this...
    echo "<p class='post'>" > $TODAY &&
    echo "</p>" >> $TODAY &&
    echo "<img class='post-img' src='./img/'>" >> $TODAY &&
    echo "<pre>" >> $TODAY &&
    echo "$1" >> $TODAY &&
    echo "</pre>" >> $TODAY &&

    #if emacs server running
    emacsclient -c $TODAY &&
    #else
    #emacs $TODAY &&
    #fi

    sudo kill -9 $(pgrep rapid) &&


    # Upon saving, the text would be put in a particular element of the "blog" page
    # write the html header to the blog html file, overwriting blog.html each time
    cat $HEAD > $BLOG &&
    #this can be wrapped up by another file...
    echo '<video class="post-vid" width="1288" height="1080" controls autoplay loop>' >> $BLOG &&
    echo '<source src="../vids/' >> $BLOG &&
    echo $1 >> $BLOG &&
    echo '.webm"' >> $BLOG && 
    echo 'type="video/webm">' >> $BLOG &&
    echo '</video>' >> $BLOG &&
    echo '<div id="posts">' >> $BLOG &&
    echo '<img class="bird-scroll" src="../img/blog-logo-6.png">' >> $BLOG &&

#    video_cat &&

    # backup the tail file to be tacked on at the end
    cat $TAIL > $TAILbak &&

    # tack on today's div with class="post"
    echo '<div class="post">' > $TAIL &&

    # add today's post
    cat $POSThead >> $TAIL &&


    cat $TODAY >> $TAIL &&


    # link to video
    echo '<br/>' >> $TAIL &&
    echo '<a href="../vids/' >> $TAIL &&
    echo $1 >> $TAIL &&
    echo '.webm">' >> $TAIL &&
    echo $1 >> $TAIL &&
    echo '</a>' >> $TAIL &&

    # tack on today's div close
    echo '</div>' >> $TAIL &&

    # add backed up tail (which should contain previous posts)
    cat $TAIL.bak >> $TAIL &&

    # add completed tail to the blog html file
    cat $TAIL >> $BLOG &&
#    rm $TODAY
    GEEK-anim.sh "$1" 5
fi




