describe('Visit the add to cart page', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it("The user can click on the product details page for a product", () => {
    cy.get(".products article").should("have.length", 2);
    cy.get(".products article a").first().click();
    cy.get("article img").should("have.class", "main-img");
    cy.get("article button.btn").click();
    cy.get('[data-testid="cart-quantity"]').should("have.text", "(1)")
  });

})