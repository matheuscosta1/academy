package br.com.tcc.project.command.discipline.receiver;

import br.com.portoseguro.payments.common.command.impl.AbstractReceiver;
import br.com.portoseguro.payments.common.gateway.annotation.CommandReceiver;
import br.com.tcc.project.command.ValidateDisciplineMenuIsUnderMinimumParametersToGiveEquivalence;

@CommandReceiver(ValidateDisciplineMenuIsUnderMinimumParametersToGiveEquivalence.class)
public class ValidateDisciplineWorkLoadIsUnderMinimumParametersToGiveEquivalenceReceiver extends AbstractReceiver<ValidateDisciplineMenuIsUnderMinimumParametersToGiveEquivalence.Request, Boolean> {

  @Override
  protected Boolean doExecute(ValidateDisciplineMenuIsUnderMinimumParametersToGiveEquivalence.Request parameter) {

    if(!parameter.getDestinyDiscipline().getWorkLoad().equals(parameter.getOriginDiscipline().getWorkLoad())) {
      return false;
    }

    return null;
  }
}
