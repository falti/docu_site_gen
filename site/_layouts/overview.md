---
layout: default
---

{% for role in site.data.roles %}
{% assign r = role[1] %}
  
    
<h1>Role:  {{ r.name }}</h1>
<h2>Description</h2>
<p>{{ r.description}}</p>

<h2>Variables:</h2>
    {% for v in r.variables %}
    <p>name: {{v.name}}</p>
    <p>type: {{v.type}} </p>
    {% endfor %} 
<hr/>  
{% endfor %}
