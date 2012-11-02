define dough::config(
  $config    = {}, 
  $content   = template("dough/${name}.erb"),
  $order     = undef,
  $target	 = '/etc/dough/dough.conf'
) {
  concat::fragment { "dough-${name}":
    target  => $target,
    content => $content,
    order   => $order,
  }
}
