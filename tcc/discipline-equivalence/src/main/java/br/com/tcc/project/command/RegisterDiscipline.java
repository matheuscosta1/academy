package br.com.tcc.project.command;

import br.com.portoseguro.payments.common.command.impl.AbstractCommand;
import br.com.portoseguro.payments.common.gateway.annotation.processor.GenerateCommandFactory;
import br.com.tcc.project.domain.Customer;

@GenerateCommandFactory
public class FindCustomerById extends AbstractCommand<String, Customer> {}
