describe('Visit the product details page', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it("The user can click on the product details page for a product", () => {
    cy.get(".products article").should("have.length", 2);

    cy.get(".products article a").first().click();
    cy.get("article img").should("have.class", "main-img")
  });

})