// SonarQube static code analysis.
//
// Check for code quality with static anaylsis scanning.
package main

import (
	"context"
	"fmt"

	"github.com/google/uuid"
)

type M1A struct{}

// Returns a container that echoes whatever string argument is provided
func (m *M1A) Build(
	ctx context.Context,
	buildSrc *Directory,
) (string, error) {
	ctr := dag.Container().
		From("docker.io/node:18").
		WithMountedDirectory("/app", buildSrc).
		WithWorkdir("/app").
		WithExec([]string{"npm", "install"}).
		WithExec([]string{"npm", "run", "build"})

	prodImage := dag.Container().
		From("docker.io/nginx:1.25.5-alpine").
		WithDirectory("/usr/share/nginx/html", ctr.Directory("/app/dist"))

	id := uuid.New()
	tag := fmt.Sprintf("ttl.sh/lucas-m1a-%s:1h", id.String())

	return prodImage.Publish(ctx, tag)
}
