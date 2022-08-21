import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Objects;
import java.util.Scanner;
import java.util.stream.Collectors;


class Application {

    public static void main(String[] args) throws JsonProcessingException {
        Scanner scanner = new Scanner(System.in);

        String input = scanner.nextLine();
 
        ObjectMapper mapper = new ObjectMapper();
        List<Request.Operation> operations = mapper.readValue(input, new TypeReference<>() {});

        //buy
        List<Request.Operation> buyOperations = operations.stream().filter(operation -> Objects.equals(operation.getOperationType(), "buy")).collect(Collectors.toList());
        Integer buyCostQuantity = buyOperations.stream().map(operation -> operation.getUnitCost() * operation.getQuantity()).reduce(0, Integer::sum);
        Integer buyTotalQuantity = buyOperations.stream().map(Request.Operation::getQuantity).reduce(0, Integer::sum);

        //sell
        List<Request.Operation> sellOperations = operations.stream().filter(operation -> Objects.equals(operation.getOperationType(), "sell")).collect(Collectors.toList());
        Integer sellCostQuantity = sellOperations.stream().map(operation -> operation.getUnitCost() * operation.getQuantity()).reduce(0, Integer::sum);
        Integer sellTotalQuantity = sellOperations.stream().map(Request.Operation::getQuantity).reduce(0, Integer::sum);

        int buyAverage = buyCostQuantity/buyTotalQuantity;
        int sellAverage = sellCostQuantity/sellTotalQuantity;
        //calculating tax
        //compra não paga imposto
        //calcular media ponderada da compra
        //usar a média ponderada da compra pra calcular prejuízo
        List<Request.Operation> lost = sellOperations.stream().filter(operation -> operation.getUnitCost() < buyAverage).collect(Collectors.toList());
        List<Request.Operation> gain = sellOperations.stream().filter(operation -> !(operation.getUnitCost() < buyAverage)).collect(Collectors.toList());


        if (!lost.isEmpty()){

        }

        System.out.println(lost);

        if(sellAverage < 20000){
            System.out.println(sellAverage);
        }

        //operations.forEach(operation -> System.out.println(buyAverage));

        //operations.forEach(operation -> operation.getOperationType());

    }
}

