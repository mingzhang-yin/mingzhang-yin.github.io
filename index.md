---
layout: default
title: Blog
---

<div>
 <h1 class="page-title">Blog</h1>
<ul>
    {% for post in site.posts %}
      <li><span>{{ post.date | date: "%Y-%m-%d" }} &raquo; </span><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
</ul>
</div>


