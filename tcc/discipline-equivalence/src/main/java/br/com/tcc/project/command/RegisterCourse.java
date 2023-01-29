package br.com.tcc.project.command;

import br.com.portoseguro.payments.common.command.impl.AbstractCommand;
import br.com.portoseguro.payments.common.gateway.annotation.processor.GenerateCommandFactory;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@GenerateCommandFactory
public class RegisterCourse extends AbstractCommand<RegisterCourse.Request, Void> {

    @Setter
    @Getter
    @Builder
    public static class Request {
        private String name;
    }
}
