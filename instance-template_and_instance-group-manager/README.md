# Instance Template & Instance Group Manager

[Compute Instance Template](https://www.terraform.io/docs/providers/google/r/compute_instance_template.html)
[Compute Instance Group Manager](https://www.terraform.io/docs/providers/google/r/compute_instance_group_manager.html)
[Compute Region (multi-zone) Instance Group Manager](https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html)


There's not option within the instance template resource to "Allow HTTP traffic" or "Allow HTTPS traffic" as one might from the Cloud Console.  If you want that here, you'll have to create a firewall rule to allow tcp:80 or tcp:443 traffic for your instance that you create from the template.
