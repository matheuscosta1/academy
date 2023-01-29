package br.com.tcc.project.command;

import br.com.portoseguro.payments.common.command.impl.AbstractCommand;
import br.com.portoseguro.payments.common.gateway.annotation.processor.GenerateCommandFactory;
import br.com.tcc.project.command.mongo.model.DisciplineDocument;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@GenerateCommandFactory
public class ValidateDisciplineWorkLoadIsUnderMinimumParametersToGiveEquivalence
    extends AbstractCommand<ValidateDisciplineWorkLoadIsUnderMinimumParametersToGiveEquivalence.Request, DisciplineDocument> {

  @Setter
  @Getter
  @Builder
  public static class Request {
    private DisciplineDocument originDiscipline;
    private DisciplineDocument destinyDiscipline;
  }
}
