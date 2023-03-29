describe('Visit the homepage', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it('displays two todo items by default', () => {
    cy.get('.hero h3').should('have.text', 'Welcome to')
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

})