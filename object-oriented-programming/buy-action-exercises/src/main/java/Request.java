import lombok.*;

import java.util.List;

@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
class Request {
    private List<Operation> operations;

    @Setter
    @Getter
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    static class Operation {

        private String operationType;
        private Integer unitCost;
        private Integer quantity;

    }
}
