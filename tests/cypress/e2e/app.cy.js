describe('app', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('Trying to start tailoring questions without sending groq key', () => {
     cy.get('#app-key-input_text').clear();
     cy.get('#app-start').click();
    cy.get('#app-out_ai-output_text').contains('Groq key'); 
  })
})
