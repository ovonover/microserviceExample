package com.example.microserviceExample;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/users")
public class UserController
{
    @GetMapping("/{id}")
    public User getUser(@PathVariable int id)
    {
        return new User();
    }
}
