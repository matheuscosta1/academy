package spring2.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import spring2.model.Produto;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
public class ProductController {

    private List<Produto> products = new ArrayList<>(
            Arrays.asList(
                    new Produto("arroz", "6"),
                    new Produto("feijao", "5")
            )
    );

    @GetMapping("/products")
    public List<Produto> getAllProducts(){
        return products;
    }

    @RequestMapping("/products/{name}")
    public ResponseEntity<Produto> getProduct(@PathVariable String name){
        for(Produto product: products){
            if(product.getName().equals(name)){
                return ResponseEntity.ok(product);
            }
        }
        return ResponseEntity.notFound().build();
    }


    @RequestMapping(method= RequestMethod.POST, value="/products")
    public void addProduct(@RequestBody Produto produto) { this.products.add(produto);}

    @DeleteMapping(path = {"/products/{name}"})
    public ResponseEntity<Produto> delete(@PathVariable String name){
        for(Produto product: products){
            if(product.getName().equals(name)){
                products.remove(product);
                return ResponseEntity.ok().build();
            }
        }
        return ResponseEntity.notFound().build();
    }


    @PutMapping(path = {"/products/{name}"})
    public ResponseEntity update(@PathVariable String name, @RequestBody Produto product){
        for(Produto produto: products){
            if(produto.getName().equals(name)){
                products.set(products.lastIndexOf(produto), product);
                return ResponseEntity.ok().build();
            }
        }
        return ResponseEntity.notFound().build();
    }

}


